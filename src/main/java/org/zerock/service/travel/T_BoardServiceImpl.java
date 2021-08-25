package org.zerock.service.travel;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import org.zerock.domain.travel.T_BoardVO;
import org.zerock.domain.travel.T_Criteria;
import org.zerock.domain.travel.T_FileVO;

import org.zerock.mapper.travel.T_BoardMapper;
import org.zerock.mapper.travel.T_FileMapper;
import org.zerock.mapper.travel.T_ReplyMapper;

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
@AllArgsConstructor
@Service
@Log4j
public class T_BoardServiceImpl implements T_BoardService {
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	
	@Setter(onMethod_= @Autowired)
	public T_BoardMapper mapper;
	
	@Setter (onMethod_ = @Autowired)
	private T_ReplyMapper replyMapper;
	
	
	@Setter(onMethod_= @Autowired)
	public T_FileMapper fileMapper;
	
	public T_BoardServiceImpl() {
		this.bucketName = "choongang-jaehyun2";
		this.profileName = "team1";
		
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
	public void register(T_BoardVO board) {
		log.info("register......." + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	@Transactional
	public void register(T_BoardVO board, MultipartFile file) {
		register(board);
		
		if (file != null && file.getSize() > 0) {
			T_FileVO vo = new T_FileVO();
			vo.setBno(board.getBno());
			vo.setFileName(file.getOriginalFilename());
			
			fileMapper.insert(vo);
			upload(board, file);
		}
	}

	private void upload(T_BoardVO board, MultipartFile file) {

		try (InputStream is = file.getInputStream()) {
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key("travel_file/" + board.getBno() + "/" + file.getOriginalFilename())
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
	public T_BoardVO get(Long bno) {
		log.info("get......." + bno);
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(T_BoardVO board) {
		log.info("modifiy......." + board);
		return mapper.update(board) == 1;
	}
	
	@Override
	@Transactional
	public boolean modify(T_BoardVO board, MultipartFile file) {
		
		if (file != null & file.getSize() > 0) {
			// s3는 삭제 후 재업로드
		    T_BoardVO oldBoard = mapper.read(board.getBno());
			removeFile(oldBoard);
			upload(board, file);
			
			// tbl_board_file은 삭제 후 인서트
			fileMapper.deleteByBno(board.getBno());
			
			T_FileVO vo = new T_FileVO();
			vo.setBno(board.getBno());
			vo.setFileName(file.getOriginalFilename());
			fileMapper.insert(vo);
		}
		return modify(board);
	}

	private void removeFile(T_BoardVO vo) {
		String key = "travel_file/" + vo.getBno() + "/" + vo.getFileName();
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		s3.deleteObject(deleteObjectRequest);
		
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove........" + bno);
		
		
		//댓글 삭제
		replyMapper.deleteByBno(bno);
		
		//파일 삭제 (s3)
		T_BoardVO vo = mapper.read(bno);
		removeFile(vo);
		
		//파일 삭제 (db)
		fileMapper.deleteByBno(bno);
		
		// 게시글 삭제
		int cnt = mapper.delete(bno);
		
		return cnt == 1;
	}

	@Override
	public List<T_BoardVO> getList(T_Criteria cri) {

		log.info("getList...............");
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(T_Criteria cri) {
		return mapper.getTotalCount(cri);
	}


	 @Override 
	 public int views(Long bno) { 
		 return mapper.views(bno); }

	
}