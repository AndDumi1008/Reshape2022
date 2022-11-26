package com.unihack.unihackbe.service;

import com.unihack.unihackbe.entity.dto.avatar.AvatarDetails;
import com.unihack.unihackbe.entity.dto.avatar.AvatarSummary;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.List;

public interface AvatarService {

    /**
     * Saves an avatar in database
     *
     * @param avatarDetails of the avatar we want to save
     * @return saved avatar
     */
    AvatarDetails save(@NotNull @Valid AvatarDetails avatarDetails);

    /**
     * Find all the avatar summary
     *
     * @return a list with all the avatar summary
     */
    List<AvatarSummary> findAll();


    /**
     * Updates all information for a specific Avatar
     *
     * @param avatarDetails the new avatar
     * @param id            the id of the avatar we want to change
     * @param birthdate     the birthdate of the avatar we want to change
     * @return the modified avatar
     */
    AvatarDetails update(AvatarDetails avatarDetails, String id, LocalDate birthdate);

    /**
     * Deletes an Avatar by id
     *
     * @param id the id of the avatar we want to delete
     */
    void deleteById(String id);

    /**
     * Get Avatar by id
     *
     * @param id the id of the avatar we want to get
     * @return the found avatar
     */
    AvatarDetails getAvatarById(@NotBlank @Valid String id);


}
