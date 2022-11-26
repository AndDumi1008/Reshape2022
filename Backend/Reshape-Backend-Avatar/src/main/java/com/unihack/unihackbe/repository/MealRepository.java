package com.unihack.unihackbe.repository;

import com.unihack.unihackbe.entity.AvatarEntity;
import com.unihack.unihackbe.entity.MealEntity;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.ArrayList;
import java.util.List;

public interface MealRepository extends MongoRepository<MealEntity, ObjectId> {
}
