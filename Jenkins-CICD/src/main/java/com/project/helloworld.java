package com.project;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class helloworld {
	
	@GetMapping("")
	public String hello()
	{
		return "Hello, World!";
	}

}
