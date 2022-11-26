package com.unihack.unihackbe.controller;


import com.unihack.unihackbe.entity.dto.meal.MealDto;
import com.unihack.unihackbe.service.MealService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/meal")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ControllerMeal {

    private final MealService mealService;

    public ControllerMeal(MealService mealService) {
        this.mealService = mealService;
    }

    @GetMapping("/{id}")
    public MealDto getMeal(@PathVariable String id) {
        return mealService.getMealById(id);
    }
}
