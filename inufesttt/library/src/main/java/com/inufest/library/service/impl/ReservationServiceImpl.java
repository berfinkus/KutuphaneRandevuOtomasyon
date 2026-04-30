package com.inufest.library.service.impl;

import com.inufest.library.dto.ReservationRequest;
import com.inufest.library.model.*;
import com.inufest.library.repository.DeskRepository;
import com.inufest.library.repository.ReservationRepository;
import com.inufest.library.repository.UserRepository;
import com.inufest.library.service.ReservationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {

    private final ReservationRepository reservationRepository;
    private final DeskRepository deskRepository;
    private final UserRepository userRepository;

    @Override
    public Reservation createReservation(String userEmail, ReservationRequest request) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        Desk desk = deskRepository.findById(request.getDeskId())
                .orElseThrow(() -> new RuntimeException("Desk not found"));

        if (desk.getStatus() != DeskStatus.AVAILABLE) {
            throw new RuntimeException("Desk is not available");
        }

        desk.setStatus(DeskStatus.RESERVED);
        deskRepository.save(desk);

        Reservation reservation = Reservation.builder()
                .user(user)
                .desk(desk)
                .startTime(request.getStartTime())
                .endTime(request.getEndTime())
                .status(ReservationStatus.PENDING)
                .build();

        return reservationRepository.save(reservation);
    }

    @Override
    public void cancelReservation(String userEmail, Long reservationId) {
        Reservation reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new RuntimeException("Reservation not found"));

        if (!reservation.getUser().getEmail().equals(userEmail)) {
            throw new RuntimeException("Not authorized to cancel this reservation");
        }

        reservation.setStatus(ReservationStatus.CANCELLED);
        reservationRepository.save(reservation);

        Desk desk = reservation.getDesk();
        desk.setStatus(DeskStatus.AVAILABLE);
        deskRepository.save(desk);
    }

    @Override
    public List<Reservation> getUserReservations(String userEmail) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return reservationRepository.findByUserIdAndStatus(user.getId(), ReservationStatus.ACTIVE);
    }

    @Override
    public void completeReservation(Long reservationId) {
        Reservation reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new RuntimeException("Reservation not found"));
        reservation.setStatus(ReservationStatus.COMPLETED);
        reservationRepository.save(reservation);

        Desk desk = reservation.getDesk();
        desk.setStatus(DeskStatus.AVAILABLE);
        deskRepository.save(desk);
    }

    @Override
    public void timeoutReservation(Long reservationId) {
        Reservation reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new RuntimeException("Reservation not found"));
        reservation.setStatus(ReservationStatus.TIMEOUT);
        reservationRepository.save(reservation);

        Desk desk = reservation.getDesk();
        desk.setStatus(DeskStatus.AVAILABLE);
        deskRepository.save(desk);
    }
}
