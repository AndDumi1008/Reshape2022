package com.unihack.unihackbe.repository;


import com.unihack.unihackbe.entity.TrainingEntity;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface TrainingRepository extends MongoRepository<TrainingEntity, ObjectId> {
}
