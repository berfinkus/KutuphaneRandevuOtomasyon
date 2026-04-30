package com.inufest.library.config;

import com.inufest.library.model.Role;
import com.inufest.library.model.User;
import com.inufest.library.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        if (userRepository.count() == 0) {
            String defaultPassword = passwordEncoder.encode("password123");

            List<User> initialUsers = List.of(
                    User.builder()
                            .name("Berfin KUŞ")
                            .email("berfin@inufest.com")
                            .password(defaultPassword)
                            .role(Role.USER)
                            .build(),
                    User.builder()
                            .name("Gamze POLAT")
                            .email("gamze@inufest.com")
                            .password(defaultPassword)
                            .role(Role.USER)
                            .build(),
                    User.builder()
                            .name("Nisa DANIŞ")
                            .email("nisa@inufest.com")
                            .password(defaultPassword)
                            .role(Role.USER)
                            .build(),
                    User.builder()
                            .name("Sueda TOPÇU")
                            .email("sueda@inufest.com")
                            .password(defaultPassword)
                            .role(Role.USER)
                            .build(),
                    User.builder()
                            .name("Şermin KUŞ")
                            .email("sermin@inufest.com")
                            .password(defaultPassword)
                            .role(Role.ADMIN)
                            .build()
            );

            userRepository.saveAll(initialUsers);
            System.out.println("Örnek kullanıcılar veritabanına eklendi.");
        }
    }
}
