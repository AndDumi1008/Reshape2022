package com.unihack.unihackbe.service;

import com.unihack.unihackbe.entity.TrainingEntity;
import com.unihack.unihackbe.entity.dto.training.TrainingDto;
import com.unihack.unihackbe.repository.TrainingRepository;
import com.unihack.unihackbe.utils.GeneralMapper;
import org.bson.types.ObjectId;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class TrainingServiceImpl implements TrainingService {

    private final TrainingRepository trainingRepository;
    private final GeneralMapper generalMapper;
    private final AvatarService avatarService;

    public TrainingServiceImpl(TrainingRepository trainingRepository, GeneralMapper generalMapper, AvatarService avatarService) {
        this.trainingRepository = trainingRepository;
        this.generalMapper = generalMapper;
        this.avatarService = avatarService;
    }

    @Override
    public TrainingDto save(TrainingDto trainingDto) {
        TrainingEntity trainingEntity = trainingRepository.save(generalMapper.dtoToEntity(trainingDto));
        return generalMapper.entityToDto(trainingEntity);
    }

    @Override
    public Map<TrainingDto, String> findAll(String id) {
        List<ObjectId> listOfTrainingId = avatarService.getEntityAvatar(id).getTrainingWeek();
        List<String> idToString = listOfTrainingId.stream().map(String::valueOf).collect(Collectors.toList());

//        List<String> exerciseDescription = new ArrayList<>(avatarService.getAvatarById(id).getTrainingWeek().values());
        Map<TrainingDto,String> map = new HashMap<>();
//
//        idToString.forEach(k -> {
//            int i = 0;
//            while(i < exerciseDescription.size()) {
//                map.put(getTrainingById(k), exerciseDescription.get(i));
//                i++;
//            }
//        } );
        map.put(getTrainingById("6382ad44b73250cc8f8d0577"), avatarService.getAvatarById("6381f2dd2d207c5f2a4df762").getTrainingWeek().get(trainingRepository.findById(new ObjectId("6381f2dd2d207c5f2a4df762"))));
        return map;
    }

//    @Override
    public TrainingDto getTrainingById(String id) {
        try {
            ObjectId trainingObjectId = generalMapper.stringToObjectId(id);
            TrainingEntity trainingEntity = trainingRepository.findById(trainingObjectId).orElseThrow();
            return generalMapper.entityToDto(trainingEntity);
        } catch (NoSuchElementException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Training was not found.", e);
        }
    }
}
