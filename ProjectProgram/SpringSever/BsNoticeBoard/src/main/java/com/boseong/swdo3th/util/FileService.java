package com.boseong.swdo3th.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

/**
 * 파일 관련 유틸
 * 업로드한 파일의 저장 & 서버에 저장된 파일 삭제 등의 기능 제공
 */
public class FileService {

	/**
	 * 업로드 된 파일을 지정된 경로에 저장하고, 저장된 파일명을 리턴
	 * @param mfile 업로드된 파일
	 * @param path 저장할 경로
	 * @return 저장된 파일명
	 */
	
	//파일명 전달받고
	//파일의 저장된 주소를 받고
	//파일이 저장된 주소에 있는지를 확인합니다.
	//마지막에는 파일명과 경로를 리턴해줍니다.
	public static String saveFile(MultipartFile mfile, String uploadPath) {
									// 내가 저장하려는 파일, 저장겅료
		/* static 메소드입니다.
		 * static을 활용시 장점은 
		 * 객체를 굳이 만들지 않아도 되고, 어디서든 참조할 수 있기 때문입니다.
		 * (가장 먼저 생성되고, 객체 생성않고도 클래스이름.메소드 식으로 선언이 가능합니다.)
		 * 
		 * static private처럼 공유가 불가능한 애가 아닙니다.
		 * 오히려 공유를 적극돕는 유형이에요.
		 * (애초에 유틸이 모두가 쓸수 있도록 하자! 라는 취지로 만드는건데 공유를 막으면...)
		 */
		
		//업로드된 파일이 없거나 크기가 0이면 저장하지 않고 null을 리턴
		//한 마디로 자료형이란 애기...
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {
			//파일이 있니?     / 파일이 비었니?       / 파일의 크기가 0이니?
			return null;//만약 3가지 경우중 하나라도 포함되면 실시않음.
		}
		
		
		//저장 폴더가 없으면 생성
		File path = new File(uploadPath); //File path : 자바안에서만 파일객체입니다.(파일객체는 파일이 아님!!) 
		if (!path.isDirectory()) {//파일객체 path에게 경로가 없다면(!가 붙었으니 not이 된다)
			path.mkdirs();	//직접 경로를 만들어라.
		}
		
		
		//사용자가 업로드하는 파일의 파일명. 
		//왜 필요하느냐? 사용자들이 똑같은 이름으로 올리는 확률이 많기에 
		//원본 파일명을 저장하고, 저장하는 파일명으로 변경하여 엉뚱한 파일로 덮어씌워지는 것을 방지하기 위해서이다.
		//(#나는 나무사진으로 올려놨는데 다른 사용자가 똑같은 파일명으로 펭귄사진을 올렸다면 펭귄으로 덮어씌워질 수 있기에
		//  원본파일명을 기록하고, 자체적으로 저장용이름을 만들기 위해서도 필요하다)
		//또한 사용자에게는 다운로드 해줄때 원본파일명으로 원래대로 주기위해서도 필요하다.
		//원본 파일명
		String originalFilename = mfile.getOriginalFilename();
		
		
		
		//저장할 파일명을 오늘 날짜의 년월일로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");//MM:month, mm:minute 구별위해 대소문자 구별하게 되었다.
		String savedFilename = sdf.format(new Date()); //(예) 20200129 식으로 오늘 날짜가 저장명으로 활용됩니다.
		
		
		
		//원본 파일의 확장자
		String ext; //확장자를 저장해줄 ext라는 변수를 선언하였다.
		int lastIndex = originalFilename.lastIndexOf('.'); 
		//originalFilename: 원본파일명 
		//lastIndexOf('.') : 뒤에서부터 점을 찾아라
		
		
		//확장자가 없는 경우
		if (lastIndex == -1) { //-1이 리턴되다 = 값이 없다, '.'이 없다는 소리이다.
			ext = "";
		}
		//확장자가 있는 경우
		else {//.은 파일명으로 쓰지 못합니다. 오로지 확장자전용으로만 쓸수 있어요.(#점은 2개이상이 없다.)
			ext = "." + originalFilename.substring(lastIndex + 1);//substring을 통해 점 이후의 확장자들을 취득한다.
			//(예) 1234.jpg라면  내게 필요한건 .jpg이다.
		}

		//저장할 전체 경로를 포함한 File 객체
		File serverFile = null;
		
		//같은 이름의 파일이 있는 경우의 처리
		while (true) {
			serverFile = new File(uploadPath + "/" + savedFilename + ext);
								//업로드 경로                           저장할 파일명            + 확장자
			
			//같은 이름의 파일이 없으면 나감.
			if ( !serverFile.isFile()) break;	
			//같은 이름의 파일이 있으면 이름 뒤에 long 타입의 시간정보를 덧붙임.
			savedFilename = savedFilename + new Date().getTime();	
			//원래파일명 뒤쪽에 시간을 덧붙여서 저장합니다. 동일명으로 인해 충돌하거나 덮어씌워지기를 방지하기 위한 것입니다.
		}		
		
		
		
		
		//---여기부터 Spring과 관련되는 코드입니다.
		//컴퓨터와 관련된 일을 한다면 파일은 필수죠
		//stream을 배우시면 알수 있씁니다

		//파일 저장
		try {
			mfile.transferTo(serverFile);
		} catch (Exception e) {
			savedFilename = null;
			e.printStackTrace();
		}
		
		return savedFilename + ext; //"내가 저장한 파일명.확장자" 를 리턴해줍니다.
		//사용자 전송->WAS(저장실시)->DB(저장완료후 "파일명.확장자" 와 파일의 저장경로"를 전달 받습니다. 
		//이를통해 서버에 저장된 파일을 DB는 차트로 관리하는 형식이 되지요. 
	}
	
	/**
	 * 서버에 저장된 파일의 전체 경로를 전달받아, 해당 파일을 삭제
	 * @param fullpath 삭제할 파일의 경로
	 * @return 삭제 여부
	 */
	public static boolean deleteFile(String fullpath) {
		//파일 삭제 여부를 리턴할 변수
		boolean result = false;
		
		//전달된 전체 경로로 File객체 생성
		File delFile = new File(fullpath);
		
		//해당 파일이 존재하면 삭제
		if (delFile.isFile()) {
			delFile.delete();
			result = true;
		}
		
		return result;
	}
}
