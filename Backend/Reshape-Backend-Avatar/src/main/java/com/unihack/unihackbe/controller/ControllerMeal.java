package com.unihack.unihackbe.controller;


import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/meal")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ControllerMeal {
}
