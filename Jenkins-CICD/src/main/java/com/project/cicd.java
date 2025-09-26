package com.project;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class cicd {
	
	@GetMapping("")
	public ModelAndView hello()
	{
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index.html");
		return mv;
	}

}
