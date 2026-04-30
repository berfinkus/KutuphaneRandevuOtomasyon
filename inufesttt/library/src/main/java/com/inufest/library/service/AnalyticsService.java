package com.inufest.library.service;

public interface AnalyticsService {
    void recordUsage(Long deskId, Integer durationMinutes);
    Long getTotalUsageMinutes();
}
