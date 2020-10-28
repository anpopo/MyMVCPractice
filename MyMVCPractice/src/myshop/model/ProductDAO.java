package myshop.model;

import java.sql.*;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDAO implements InterProductDAO {
	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	////////////////////////////////////////////////////////////////////////////////////////////////
	// DataSource의 Connection Pool에 연결하기 위한 기본환경설정을 위해 기본생성자에서 환경설정을 해준다.
	
	public ProductDAO() {
	
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/mymvcpractice_oracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	private void close() {
		
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	
	@Override
	public List<ImageVO> imageSelectAll() throws SQLException {
		List<ImageVO> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select imgno, imgfilename\n"+
					"    from tbl_main_image\n"+
					"    order by imgno";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ImageVO imgvo = new ImageVO();
				
				imgvo.setImgno(rs.getInt(1));
				imgvo.setImgfilename(rs.getString(2));
				
				imgList.add(imgvo);
				
			}
			
		} finally {
			close();
		}
		
		return imgList;
	}

}
