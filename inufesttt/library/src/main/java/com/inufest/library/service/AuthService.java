package com.inufest.library.service;

import com.inufest.library.dto.AuthenticationRequest;
import com.inufest.library.dto.AuthenticationResponse;
import com.inufest.library.dto.RegisterRequest;

public interface AuthService {
    AuthenticationResponse register(RegisterRequest request);
    AuthenticationResponse authenticate(AuthenticationRequest request);
}
