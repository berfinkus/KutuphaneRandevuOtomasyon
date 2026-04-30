package com.inufest.library.controller;

import com.inufest.library.dto.ReservationRequest;
import com.inufest.library.model.Reservation;
import com.inufest.library.service.ReservationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reservations")
@RequiredArgsConstructor
public class ReservationController {

    private final ReservationService reservationService;

    @PostMapping
    public ResponseEntity<Reservation> createReservation(
            @RequestBody ReservationRequest request,
            Authentication authentication
    ) {
        return ResponseEntity.ok(reservationService.createReservation(authentication.getName(), request));
    }

    @GetMapping
    public ResponseEntity<List<Reservation>> getUserReservations(Authentication authentication) {
        return ResponseEntity.ok(reservationService.getUserReservations(authentication.getName()));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> cancelReservation(
            @PathVariable Long id,
            Authentication authentication
    ) {
        reservationService.cancelReservation(authentication.getName(), id);
        return ResponseEntity.ok().build();
    }
}
