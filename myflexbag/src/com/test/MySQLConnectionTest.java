package com.test;

import java.sql.Connection;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.sql.DataSource;
 
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.frame.Service;
import com.vo.BoardVO;
 
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:web/WEB-INF/config/spring.xml" })
public class MySQLConnectionTest {
    
    @Inject
    private DataSource ds;
 
    @Test
    public void testConnection() throws Exception {
 
        try (Connection con = ds.getConnection()) {
 
            System.out.println("\n >>>>>>>>>> Connection 출력 : " + con + "\n");
 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
	@Resource(name = "bservice")
	Service<String, BoardVO> bservice;
    
    @Test
    public void testCreate() throws Exception{
    	for(int i=1;i<1000;i++) {
    		BoardVO boardVO = new BoardVO();
    		boardVO.setUserid("sample");
    		boardVO.setBtitle(i+"번째 글 제목입니다");
    		boardVO.setBkind("delivery");
    		bservice.register(boardVO);
    		
    	}
    }
}
