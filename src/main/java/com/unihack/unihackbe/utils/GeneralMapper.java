package com.unihack.unihackbe.utils;

import com.unihack.unihackbe.entity.AvatarEntity;
import com.unihack.unihackbe.entity.MealEntity;
import com.unihack.unihackbe.entity.dto.avatar.AvatarDetails;
import com.unihack.unihackbe.entity.dto.avatar.AvatarSummary;
import com.unihack.unihackbe.entity.dto.meal.MealDto;
import org.bson.types.ObjectId;
import org.mapstruct.InjectionStrategy;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring", injectionStrategy = InjectionStrategy.CONSTRUCTOR)
public abstract class GeneralMapper {

    @Named("objectIdToString")
    public String objectIdToString(ObjectId objectId) {
        return objectId.toString();
    }

    @Named("stringToObjectId")
    public ObjectId stringToObjectId(String stringObjectId) {
        if (stringObjectId == null || stringObjectId.length() == 0) {
            return null;
        }
        return new ObjectId(stringObjectId);
    }

    @Named("integerToString")
    public String intToString(Integer number) {
        return Integer.toString(number);
    }

    @Named("stringToInteger")
    public Integer stringToInt(String number) {
        return Integer.valueOf(number);
    }

    @Named("floatToString")
    public String floatToString(Float number) {
        return Float.toString(number);
    }

    @Named("stringToFloat")
    public Float stringToFloat(String number) {
        return Float.parseFloat(number);
    }

    @Named("computeAgeToString")
    public String computeAgeToString(LocalDate birthday) {
        Period age = Period.ofYears(Period.between(birthday, LocalDate.now()).getYears());
        return String.valueOf(age.getYears());
    }

//    @Named("avatarMealDto")
//    public List<MealDto> avatarMealDto(List<ObjectId> avatarMealId) {
////        return avatarMealEntity.entrySet().stream().collect(Collectors.toMap(e -> entityToDto(e.getKey()), Entry::getValue));
//        List<MealDto> returnedList = avatarMealId.stream().
//        return returnedList;
//    }


    /**
     * Mapper functions for {@link AvatarEntity}
     * */

    @Mapping(source = "id", target = "id", qualifiedByName = "objectIdToString")
    @Mapping(target = "mealsWeek", ignore = true)
    public abstract AvatarSummary entityToSummary(AvatarEntity entity);

    @Mapping(source = "id", target = "id", qualifiedByName = "objectIdToString")
    @Mapping(source = "birthDate", target = "age", qualifiedByName = "computeAgeToString")
    public abstract AvatarDetails entityToDetails(AvatarEntity entity);

    @Mapping(source = "id", target = "id", qualifiedByName = "stringToObjectId")
    @Mapping(source = "birthDate", target = "age", qualifiedByName = "computeAgeToString")
    public abstract AvatarEntity detailsToEntity(AvatarDetails avatarDetails);

    public abstract List<AvatarSummary> avatarEntityListToAvatarSummaryList(List<AvatarEntity> avatarEntityList);


    /**
     * Mapper functions for {@link MealEntity}
     * */

    @Named("entityToDto")
    @Mapping(source = "id", target = "id", qualifiedByName = "objectIdToString")
    @Mapping(source = "kcal", target = "kcal", qualifiedByName = "integerToString")
    public abstract MealDto entityToDto(MealEntity entity);

    @Mapping(source = "id", target = "id", qualifiedByName = "stringToObjectId")
    @Mapping(source = "kcal", target = "kcal", qualifiedByName = "stringToInteger")
    public abstract MealEntity dtoToEntity(MealDto dto);

//    public abstract List<MealDto> mealEntityListToMealDtoList(List<MealEntity> avatarEntityList);

}