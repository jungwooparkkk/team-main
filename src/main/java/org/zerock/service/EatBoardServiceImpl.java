package org.zerock.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.Criteria;
import org.zerock.domain.EatBoardVO;
import org.zerock.domain.EatFileVO;
import org.zerock.mapper.EatBoardMapper;
import org.zerock.mapper.EatFileMapper;
import org.zerock.mapper.EatReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Log4j
@Service
@AllArgsConstructor
public class EatBoardServiceImpl implements EatBoardService {
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	
	@Setter(onMethod_= @Autowired)
	public EatBoardMapper mapper;
	
	@Setter (onMethod_ = @Autowired)
	private EatReplyMapper replyMapper;
	
	
	@Setter(onMethod_= @Autowired)
	public EatFileMapper fileMapper;
	
	public EatBoardServiceImpl() {
		this.bucketName = "choongang-jaehyun2";
		this.profileName = "spring1";
		
		/*  
		 * create
		 *  /home/tomcat/.aws/credentials
		 */
		
		Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		ProfileFile pf = ProfileFile.builder()
				.content(contentLocation)
				.type(ProfileFile.Type.CREDENTIALS)
				.build();
		ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
				.profileFile(pf)
				.profileName(profileName)
				.build();
		
		this.s3 = S3Client.builder()
				.credentialsProvider(pcp)
				.build();
	}

	@Override
	public void register(EatBoardVO board) {
		log.info("register......." + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	@Transactional
	public void register(EatBoardVO board, MultipartFile file) {
		register(board);
		
		if (file != null && file.getSize() > 0) {
			EatFileVO vo = new EatFileVO();
			vo.setEatbno(board.getEatbno());
			vo.setFileName(file.getOriginalFilename());
			
			fileMapper.insert(vo);
			upload(board, file);
		}
	}

	private void upload(EatBoardVO board, MultipartFile file) {

		try (InputStream is = file.getInputStream()) {
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(board.getEatbno() + "/" + file.getOriginalFilename())
					.contentType(file.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			s3.putObject(objectRequest, 
					RequestBody.fromInputStream(is, file.getSize()));
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}
	
	
	@Override
	public EatBoardVO get(Long eatbno) {
		log.info("get......." + eatbno);
		
		return mapper.read(eatbno);
	}

	@Override
	public boolean modify(EatBoardVO board) {
		log.info("modifiy......." + board);
		
		return mapper.update(board) == 1;
	}
	
	@Override
	@Transactional
	public boolean modify(EatBoardVO board, MultipartFile file) {
		
		if (file != null & file.getSize() > 0) {
			// s3는 삭제 후 재업로드
			EatBoardVO oldBoard = mapper.read(board.getEatbno());
			removeFile(oldBoard);
			upload(board, file);
			
			// tbl_board_file은 삭제 후 인서트
			fileMapper.deleteByEatBno(board.getEatbno());
			
			EatFileVO vo = new EatFileVO();
			vo.setEatbno(board.getEatbno());
			vo.setFileName(file.getOriginalFilename());
			fileMapper.insert(vo);
		}
		return modify(board);
	}

	private void removeFile(EatBoardVO vo) {
		String key = vo.getEatbno() + "/" + vo.getFileName();
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		s3.deleteObject(deleteObjectRequest);
		
	}

	@Override
	public boolean remove(Long eatbno) {
		log.info("remove........" + eatbno);
		
		
		//댓글 삭제
		replyMapper.deleteByBno(eatbno);
		
		//파일 삭제 (s3)
		EatBoardVO vo = mapper.read(eatbno);
		removeFile(vo);
		
		//파일 삭제 (db)
		fileMapper.deleteByEatBno(eatbno);
		
		// 게시글 삭제
		int cnt = mapper.delete(eatbno);
		
		return cnt == 1;
	}

	@Override
	public List<EatBoardVO> getList(Criteria cri) {

		log.info("getList...............");

		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	 @Override 
	 public int views(Long eatbno) { 
		 return mapper.views(eatbno); }
}
