package com.inufest.library.repository;

import com.inufest.library.model.Desk;
import com.inufest.library.model.DeskStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DeskRepository extends JpaRepository<Desk, Long> {
    List<Desk> findByStatus(DeskStatus status);
}
