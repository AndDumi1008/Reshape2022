package com.unihack.unihackbe.service;


import com.unihack.unihackbe.entity.MealEntity;
import com.unihack.unihackbe.entity.dto.meal.MealDto;
import com.unihack.unihackbe.repository.MealRepository;
import com.unihack.unihackbe.utils.GeneralMapper;
import org.bson.types.ObjectId;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class MealServiceImpl implements MealService {

    private final MealRepository mealRepository;
    private final AvatarService avatarService;
    private final GeneralMapper generalMapper;

    public MealServiceImpl(MealRepository mealRepository, AvatarService avatarService, GeneralMapper generalMapper) {
        this.mealRepository = mealRepository;
        this.avatarService = avatarService;
        this.generalMapper = generalMapper;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public MealDto save(MealDto mealDto) {
        MealEntity mealEntity = mealRepository.save(generalMapper.dtoToEntity(mealDto));

        return generalMapper.entityToDto(mealEntity);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public List<MealDto> findAll(String id) {

        List<ObjectId> listOfMealId = avatarService.getEntityAvatar(id).getMealsWeek();
        List<String> strings = listOfMealId.stream().map(String::valueOf).collect(Collectors.toList());

        return strings.stream().map(this::getMealById).collect(Collectors.toList());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public MealDto update(MealDto mealDto, String id) {
        try {
            ObjectId mealId = generalMapper.stringToObjectId(id);
            MealEntity mealEntity = mealRepository.findById(mealId).orElseThrow();
            mealEntity.setKcal(Integer.valueOf(mealDto.getKcal()));
            mealEntity.setName(mealDto.getName());
            mealEntity.setReceiptUrl(mealDto.getReceiptUrl());

            MealEntity updatedMeal = mealRepository.save(mealEntity);

            return generalMapper.entityToDto(updatedMeal);
        } catch (NoSuchElementException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The meal was not found.", e);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void deleteById(String id) {
        try {
            ObjectId mealId = generalMapper.stringToObjectId(id);
            mealRepository.findById(mealId).orElseThrow();
            mealRepository.deleteById(mealId);
        } catch (NoSuchElementException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The meal was not found.", e);
        }
    }

    /**
     * {@inheritDoc}
     */
    public MealDto getMealById(String id) {
        try {
            ObjectId mealObjectId = generalMapper.stringToObjectId(id);
            MealEntity mealEntity = mealRepository.findById(mealObjectId).orElseThrow();

            return generalMapper.entityToDto(mealEntity);
        } catch (NoSuchElementException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "The meal was not found.", e);
        }
    }
}
