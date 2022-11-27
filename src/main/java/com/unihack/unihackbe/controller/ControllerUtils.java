package com.unihack.unihackbe.controller;


import com.unihack.unihackbe.entity.dto.meal.MealDto;
import com.unihack.unihackbe.entity.dto.training.TrainingDto;
import com.unihack.unihackbe.service.MealService;
import com.unihack.unihackbe.service.TrainingService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/utils")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ControllerUtils {

    private final TrainingService trainingService;

    public ControllerUtils(TrainingService trainingService) {
        this.trainingService = trainingService;
    }

//    @GetMapping("/{id}")
//    public TrainingDto getTraining(@PathVariable String id) {
//        return trainingService.getTrainingById(id);
//    }

    @GetMapping("/{id}")
    public Map<TrainingDto,String> getTraining(@PathVariable String id) {
        return trainingService.findAll(id);
    }
}
