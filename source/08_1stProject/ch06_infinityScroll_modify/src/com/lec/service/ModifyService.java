package com.lec.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.dao.FriendDao;
import com.lec.dto.FriendDto;

public class ModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int no = Integer.parseInt(request.getParameter("no"));
		String name = request.getParameter("name");
		String tel = request.getParameter("tel");
		String addr = request.getParameter("addr");
		FriendDto modifyFriend = new FriendDto(no, name, tel, addr);
		System.out.println(modifyFriend + "수정함");
		FriendDao dao = new FriendDao();
		dao.modifyFriend(modifyFriend);
		// ajaxModify에서 필요한 부분
		request.setAttribute("modifyFriend", modifyFriend);
	}
}