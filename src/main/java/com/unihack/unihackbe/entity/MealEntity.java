package com.unihack.unihackbe.entity;

import lombok.Builder;
import lombok.Data;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document("meal")
@Data
@Builder
public class MealEntity {

    @Id
    private ObjectId id;

    private String name;

    private Integer kcal;

    private String recipeUrl;
}
