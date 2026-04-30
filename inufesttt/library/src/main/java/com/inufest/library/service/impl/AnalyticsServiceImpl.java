package com.inufest.library.service.impl;

import com.inufest.library.model.Desk;
import com.inufest.library.model.UsageLog;
import com.inufest.library.repository.DeskRepository;
import com.inufest.library.repository.UsageLogRepository;
import com.inufest.library.service.AnalyticsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class AnalyticsServiceImpl implements AnalyticsService {

    private final UsageLogRepository usageLogRepository;
    private final DeskRepository deskRepository;

    @Override
    public void recordUsage(Long deskId, Integer durationMinutes) {
        Desk desk = deskRepository.findById(deskId)
                .orElseThrow(() -> new RuntimeException("Desk not found"));

        UsageLog log = UsageLog.builder()
                .desk(desk)
                .durationMinutes(durationMinutes)
                .recordedAt(LocalDateTime.now())
                .build();
        
        usageLogRepository.save(log);
    }

    @Override
    public Long getTotalUsageMinutes() {
        return usageLogRepository.findAll().stream()
                .mapToLong(UsageLog::getDurationMinutes)
                .sum();
    }
}
