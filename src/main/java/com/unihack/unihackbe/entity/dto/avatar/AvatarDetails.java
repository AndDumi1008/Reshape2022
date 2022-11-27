package com.unihack.unihackbe.entity.dto.avatar;

import com.unihack.unihackbe.entity.dto.meal.MealDto;
import com.unihack.unihackbe.entity.dto.training.TrainingDto;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Map;

@SuperBuilder
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class AvatarDetails extends AvatarDto {

    private String shortBio;
    private String smallUrl;
    private String backgroundUrl;
    private String age;
    private String netWorth;

    @NotNull
    private String wakeUpTime;

    @NotNull
    private String sleepTime;

    List<MealDto> mealsWeek;

    Map<TrainingDto, String> trainingWeek;
}
