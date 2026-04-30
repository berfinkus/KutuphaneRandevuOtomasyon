package com.inufest.library.service;

import com.inufest.library.dto.ReservationRequest;
import com.inufest.library.model.Reservation;

import java.util.List;

public interface ReservationService {
    Reservation createReservation(String userEmail, ReservationRequest request);
    void cancelReservation(String userEmail, Long reservationId);
    List<Reservation> getUserReservations(String userEmail);
    void completeReservation(Long reservationId);
    void timeoutReservation(Long reservationId);
}
