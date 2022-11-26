package com.unihack.unihackbe.service;

import com.unihack.unihackbe.entity.dto.meal.MealDto;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

public interface MealService {

    /**
     * Saves an meal in database
     *
     * @param {@link MealDto} of the meal we want to save
     * @return saved {@link MealDto}
     */
    MealDto save(@NotNull @Valid MealDto mealDto);


    /**
     * Find all the meals from avatar
     *
     * @return a list with all the {@link MealDto}
     */
    List<MealDto> findAll(@NotNull @Valid String id);

    /**
     * Updates all information for a specific meal
     *
     * @param mealDto the new meal
     * @param id      the id of the meal we want to change
     * @return the modified {@link MealDto}
     */
    MealDto update(MealDto mealDto, String id);


    /**
     * Deletes a meal by id
     *
     * @param id the id of the {@link MealDto} we want to delete
     */
    void deleteById(String id);

    /**
     * Get {@link MealDto} by id
     *
     * @param id the id of the meal we want to get
     * @return the found {@link MealDto}
     */
    MealDto getMealById(@NotBlank @Valid String id);

}
