package com.unihack.unihackbe.repository;

import com.unihack.unihackbe.entity.MealEntity;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface MealRepository extends MongoRepository<MealEntity, ObjectId> {
}
