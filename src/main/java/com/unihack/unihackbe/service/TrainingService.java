package com.unihack.unihackbe.service;

import com.unihack.unihackbe.entity.dto.training.TrainingDto;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Map;

public interface TrainingService {

    TrainingDto save(@NotNull @Valid TrainingDto trainingDto);

    Map<TrainingDto, String> findAll(@NotNull @Valid String id);

    TrainingDto getTrainingById(@NotBlank @Valid String id);

}
