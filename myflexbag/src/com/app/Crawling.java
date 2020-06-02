package com.app;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Crawling {

	public static List<String> crawling() {
		// 구글 이미지 검색 화면
		String VIEWER_URL = "https://www.google.com/search?q=men+luxury+bag&tbm=isch&ved=2ahUKEwjjgomi6bjpAhXDAJQKHfeICbwQ2-cCegQIABAA&oq=men+luxury+bag&gs_lcp=CgNpbWcQAzIECAAQEzIICAAQCBAeEBMyCAgAEAgQHhATMggIABAIEB4QEzIICAAQCBAeEBMyCAgAEAgQHhATMggIABAIEB4QEzIICAAQCBAeEBMyCAgAEAgQHhATMggIABAIEB4QEzoGCAAQBxAeOggIABAIEAcQHlClsANYw8EDYJfEA2gBcAB4AIABzAGIAccNkgEGMC4xMC4xmAEAoAEBqgELZ3dzLXdpei1pbWc&sclient=img&ei=WRfAXqPyAcOB0AT3kabgCw&bih=914&biw=1920";

		Document rawData;
		Elements imgs = null;

		try {
			rawData = Jsoup.connect(VIEWER_URL).timeout(5000).get();
			imgs = rawData.select("img[class=rg_i Q4LuWd tx8vtf]"); 

		} catch (IOException e) {
			e.printStackTrace();
		}
		// 이미지 주소를 담을 리스트 생성
		List<String> imageUrls = new ArrayList<>();
		
		for (Element img : imgs) {
			imageUrls.add(img.attr("abs:data-src"));
		}	
		return imageUrls;		
	}
}
