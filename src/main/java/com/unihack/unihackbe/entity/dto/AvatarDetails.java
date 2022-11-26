package com.unihack.unihackbe.entity.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.NotNull;
import java.util.List;

@SuperBuilder
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class AvatarDetails extends AvatarDto {

    private String shortBio;
    private String smallUrl;
    private String backgroundUrl;
    private String age;

    @NotNull
    private String wakeUpTime;

    @NotNull
    private String sleepTime;

    List<String> mealsWeek;

    List<String> trainingWeek;
}
