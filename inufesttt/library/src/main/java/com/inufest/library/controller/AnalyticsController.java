package com.inufest.library.controller;

import com.inufest.library.service.AnalyticsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/analytics")
@RequiredArgsConstructor
public class AnalyticsController {

    private final AnalyticsService analyticsService;

    @GetMapping("/total-usage")
    public ResponseEntity<Long> getTotalUsageMinutes() {
        return ResponseEntity.ok(analyticsService.getTotalUsageMinutes());
    }
}
