package com.poseidon.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.poseidon.db.DBConnection;
import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.CommentDTO;
import com.poseidon.util.Util;

public class BoardDAO extends AbstractDAO {

	public List<BoardDTO> boardList(int page) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		// db정보
		//DBConnection db = DBConnection.getInstance();
		// conn객체
		Connection con = db.getConnection();
		// pstmt
		PreparedStatement pstmt = null;
		// rs
		ResultSet rs = null;
		// sql
		String sql = "SELECT * FROM boardview LIMIT ?, 10";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (page - 1) * 10);
			rs = pstmt.executeQuery();
			

			while (rs.next()) {
				BoardDTO e = new BoardDTO();
				e.setNo(rs.getInt("board_no"));
				e.setTitle(rs.getString("board_title"));
				e.setWrite(rs.getString("board_write"));
				e.setDate(rs.getString("board_date"));
				e.setCount(rs.getInt("board_count"));
				e.setComment(rs.getInt("comment"));
				list.add(e);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);

		}

		return list;

	}

	/*
	 * private void close(ResultSet rs, PreparedStatement pstmt, Connection con) {
	 * if (rs != null) { try { rs.close(); } catch (SQLException e) {
	 * e.printStackTrace(); }
	 * 
	 * } if (pstmt != null) { try { pstmt.close(); } catch (SQLException e) {
	 * e.printStackTrace(); } } if (con != null) { try { con.close(); } catch
	 * (SQLException e) { e.printStackTrace(); } }
	 * 
	 * }
	 */

	public BoardDTO detail(int no) {
		//countUp(no);//조회수 올리기
		BoardDTO dto = new BoardDTO();

		Connection con = DBConnection.getInstance().getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT b.board_no, b.board_title, b.board_content, "
				+ "m.mname as board_write, m.mid, b.board_date, b.board_ip,"
				+ "(SELECT COUNT(*) FROM visitcount WHERE board_no=b.board_no) AS board_count"
				+ " FROM board b JOIN member m ON b.mno=m.mno "
				+ "WHERE b.board_no=?";

		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setNo(rs.getInt("board_no"));
				dto.setTitle(rs.getString("board_title"));
				dto.setContent(rs.getString("board_content"));
				dto.setWrite(rs.getString("board_write"));
				dto.setDate(rs.getString("board_date"));
				dto.setCount(rs.getInt("board_count"));
				dto.setMid(rs.getString("mid"));
				dto.setIp(rs.getString("board_ip"));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return dto;
	}

	public void countUp(int no, String mid) {
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//String sql = "UPDATE board SET board_count = board_count + 1 WHERE board_no=?";
		String sql = "SELECT count(*) FROM visitcount "
				+ "WHERE board_no=? AND mno=(SELECT mno FROM member WHERE mid=?)";
		
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.setString(2, mid);
			//pstmt.execute();
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int result = rs.getInt(1);
				//System.out.println("해당 페이지에 내가 방문한 적이 있나? " + result);
				if(result == 0) { //읽은 적 없는 사람이 조회한다면~~
					realCountUp(no,mid);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		
	}
	
	private void realCountUp(int no, String mid) {
		
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO visitcount (board_no, mno) "
				+ "VALUES(?, (SELECT mno FROM member WHERE mid=?))";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.setString(2, mid);
			pstmt.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);		}
		
		
	}

	public int Write(BoardDTO dto) {
		int result = 0;

		Connection con = DBConnection.getInstance().getConnection();
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO board (board_title, board_content, mno, board_ip) "
				+ "VALUES(?,?,(SELECT mno FROM member WHERE mid=?), ?)";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getMid()); //수정 완
			pstmt.setString(4, dto.getIp()); //아이피 추가
			result = pstmt.executeUpdate(); // 영향받은 행을 result에 저장합니다.
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		return result;
	}

	public int delete(BoardDTO dto) {
		int result = 0;
		// conn
		Connection con = DBConnection.getInstance().getConnection();
		
		// pstmt
		PreparedStatement pstmt = null;
		
		// sql
		String sql = "UPDATE board SET board_del='0' WHERE board_no=? AND mno=(SELECT mno FROM member WHERE mid=?)";

		//TRY/CATCH
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNo()); //dto -> dto.getno() 로 인트값으로
			pstmt.setString(2, dto.getMid());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		
		
		return result;

	}

	public int update(BoardDTO dto) {
		int result = 0;
		Connection con = DBConnection.getInstance().getConnection();
		PreparedStatement pstmt = null;
		String sql = "UPDATE board SET board_title=?, board_content=?"
				+ " WHERE board_no=? AND mno=(SELECT mno FROM member WHERE mid=?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNo());
			pstmt.setString(4, dto.getMid());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
				
		return result;
	}

	public int totalCount() {
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM boardview";
		int result = 0;
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return result;
	}

	public List<CommentDTO> commentList(int no) {
		List<CommentDTO> list = new ArrayList<CommentDTO>();
		Connection con = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//String sql = "SELECT * FROM comment WHERE board_no=?";
		String sql = "SELECT * FROM commentview WHERE board_no=?";
		
//		CREATE VIEW commentview as
//		SELECT c.cno, c.board_no, c.ccomment,
//		if(date_format(cdate,'%Y-%m-%d')=date_format(NOW(),'%Y-%m-%d'),
//		date_format(cdate,'%h-%i'),
//		date_format(cdate,'%Y-%m-%d')) AS cdate,
//		c.clike, m.mno, m.`mid`, m.mname
//		FROM comment c JOIN member m ON c.mno = m.mno
//		ORDER BY c.cno desc
			
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				CommentDTO dto = new  CommentDTO();
				dto.setCno(rs.getInt("cno"));
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setCcomment(rs.getString("ccomment"));
				dto.setCdate(rs.getString("cdate"));
				dto.setMno(rs.getInt("mno"));
				//뷰 만들어서 mname, mid 가져오게 하기
				dto.setMid(rs.getString("mid"));
				dto.setMname(rs.getString("mname"));
				dto.setClike(rs.getInt("clike"));
				dto.setIp(Util.ipMasking(rs.getString("cip")));
				
				list.add(dto);
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		
		return list;
	}

}
