package com.xpower.xpowerdesign.user;

import com.xpower.xpowerdesign.user.domain.User;
import com.xpower.xpowerdesign.user.domain.UserRepository;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/users")
@Api(tags = "用户")
public class UserController {
    private UserRepository userRepository;

    @Autowired
    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping
    @ApiOperation(value = "获取用户列表")
    public List<User> getUsers() {
        return userRepository.findAll();
    }
}
