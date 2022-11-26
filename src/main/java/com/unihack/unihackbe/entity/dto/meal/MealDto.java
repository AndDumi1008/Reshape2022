package com.unihack.unihackbe.entity.dto.meal;


import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class MealDto {

    private String id;

    private String name;

    private String kcal;


    private String receiptUrl;
}
