package com.inufest.library.config;

import com.inufest.library.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@RequiredArgsConstructor
public class ApplicationConfig {

    private final UserRepository userRepository;

    @Bean
    public UserDetailsService userDetailsService() {
        return username -> userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        // Wait, apparently DaoAuthenticationProvider does not have a no-args constructor in some recent version, or does it?
        // Let's just avoid DaoAuthenticationProvider if it causes compile issues, wait... actually, we just need to satisfy it.
        // Wait! The error wasn't saying DaoAuthenticationProvider changed. Look at the error from my `mvn clean compile`:
        // [ERROR] /Users/berfinskus/Desktop/inufesttt/library/src/main/java/com/inufest/library/config/ApplicationConfig.java:[30,50] constructor DaoAuthenticationProvider in class org.springframework.security.authentication.dao.DaoAuthenticationProvider cannot be applied to given types;
        // required: org.springframework.security.core.userdetails.UserDetailsService
        // found: no arguments
        
        // Wait, why did it require UserDetailsService?
        // Because DaoAuthenticationProvider might have changed? I'll pass userDetailsService() in the constructor.
        
        // Wait, does `setPasswordEncoder` exist? Let's check the error again.
        // `cannot find symbol: method setUserDetailsService(org.springframework.security.core.userdetails.UserDetailsService)`
        // It says `setUserDetailsService` cannot be found. What about `setPasswordEncoder`? It didn't error on `setPasswordEncoder`! So `setPasswordEncoder` exists.
        
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
