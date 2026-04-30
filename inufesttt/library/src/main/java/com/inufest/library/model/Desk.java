package com.inufest.library.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "desks")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Desk {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String deskNumber;

    @Column(nullable = false)
    private String location;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DeskStatus status;
}
