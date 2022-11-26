package com.unihack.unihackbe.utils;

import com.unihack.unihackbe.entity.AvatarEntity;
import com.unihack.unihackbe.entity.dto.AvatarDetails;
import com.unihack.unihackbe.entity.dto.AvatarSummary;
import org.bson.types.ObjectId;
import org.mapstruct.InjectionStrategy;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

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
        return Integer.getInteger(number);
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


    /*Mapper functions for Avatar.class */
    @Mapping(source = "id", target = "id", qualifiedByName = "objectIdToString")
    public abstract AvatarSummary entityToSummary(AvatarEntity entity);

    @Mapping(source = "id", target = "id", qualifiedByName = "objectIdToString")
    @Mapping(source = "birthDate", target = "age", qualifiedByName = "computeAgeToString")
    public abstract AvatarDetails entityToDetails(AvatarEntity entity);

    @Mapping(source = "id", target = "id", qualifiedByName = "stringToObjectId")
    public abstract AvatarEntity detailsToEntity(AvatarDetails avatarDetails);

    public abstract List<AvatarSummary> avatarEntityListToAvatarSummaryList(List<AvatarEntity> avatarEntityList);


}
