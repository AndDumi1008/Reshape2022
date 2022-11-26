package com.unihack.unihackbe.controller;

import com.unihack.unihackbe.entity.dto.avatar.AvatarDetails;
import com.unihack.unihackbe.entity.dto.avatar.AvatarSummary;
import com.unihack.unihackbe.service.AvatarService;
import com.unihack.unihackbe.service.MealService;
import io.swagger.v3.oas.annotations.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ControllerAvatar {

    private final AvatarService avatarService;
    private final MealService mealService;

    @Autowired
    public ControllerAvatar(AvatarService avatarService, MealService mealService) {
        this.avatarService = avatarService;
        this.mealService = mealService;
    }

    @GetMapping("/")
    public List<AvatarSummary> getAllAvatars() {
        return avatarService.findAll();
    }

    @GetMapping("/{id}")
    public AvatarDetails getAvatarById(@Parameter(description = "id of the avatar to be founded", required = true) @Valid @PathVariable String id) {
        return avatarService.getAvatarById(id);
    }

    @PutMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public AvatarDetails updateAvatar(@Valid @RequestBody AvatarDetails avatarDetails, @Valid @RequestBody LocalDate birthdate, @Parameter(description = "id of the avatar to be founded", required = true) @PathVariable String id) {
        return avatarService.update(avatarDetails, id, birthdate);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteAvatarById(@Parameter(description = "id of the avatar to be founded", required = true) @PathVariable String id) {
        avatarService.deleteById(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public AvatarDetails saveAvatar(@Valid @RequestBody AvatarDetails avatarDetails) {
        return avatarService.save(avatarDetails);
    }
}
