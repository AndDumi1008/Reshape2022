package com.unihack.unihackbe.entity;

import lombok.Builder;
import lombok.Data;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document("training")
@Data
@Builder
public class TrainingEntity {

    @Id
    private ObjectId id;

    private String name;
    private String exerciseUrl;
}
