package kg.attractor.java25.microgram.mapper;

import kg.attractor.java25.microgram.dto.*;
import kg.attractor.java25.microgram.model.User;
import kg.attractor.java25.microgram.service.PostService;
import kg.attractor.java25.microgram.service.UserService;
import org.springframework.security.core.Authentication;

public class UserMapper {
    public static UserResponseDto toDto(User user) {
        if (user == null) return null;
        UserResponseDto userResponseDto = new UserResponseDto();
        userResponseDto.setId(user.getId());
        userResponseDto.setUsername(user.getUsername());
        userResponseDto.setEmail(user.getEmail());
        userResponseDto.setDisplayName(user.getDisplayName());
        userResponseDto.setBio(user.getBio());
        userResponseDto.setAvatar(user.getAvatar());
        return userResponseDto;
    }

    public static User fromDto(UserRequestDto userRequestDto) {
        if (userRequestDto == null) return null;
        User user = new User();
        user.setName(userRequestDto.getUsername());
        user.setEmail(userRequestDto.getEmail());
        user.setPassword(userRequestDto.getPassword());
        user.setDisplayName(userRequestDto.getDisplayName());
        user.setBio(userRequestDto.getBio());
        user.setAvatar(userRequestDto.getAvatar());
        return user;
    }

    public static User userRegister(UserRegisterDto dto) {
        if (dto == null) return null;
        User user = new User();
        user.setName(dto.getUsername());
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        user.setDisplayName(dto.getDisplayName());
        user.setEnabled(true);
        user.setRole("ROLE_USER");
        user.setPostsCount(0);
        user.setFollowersCount(0);
        user.setFollowingCount(0);
        return user;
    }

    public static UserProfileDto ProfileDto(User user, Authentication auth, UserService userService, PostService postService) {
        if (user == null) return null;
        UserProfileDto userProfileDto = new UserProfileDto();
        userProfileDto.setId(user.getId());
        userProfileDto.setUsername(user.getName());
        userProfileDto.setDisplayName(user.getDisplayName());
        userProfileDto.setBio(user.getBio());
        userProfileDto.setEmail(user.getEmail());
        userProfileDto.setAvatar(user.getAvatar());

        userProfileDto.setPostsCount(userService.getPostsCount(user));
        user.setFollowersCount(userService.getFollowersCount(user));
        user.setFollowingCount(userService.getFollowingCount(user));

        if (auth != null) {
            User currentUser = userService.findByEmail(auth.getName());
            userProfileDto.setFollowing(userService.isFollowing(currentUser, user));
        }

        return userProfileDto;
    }
    public static UserDto fromDto(User user) {
        if (user == null) return null;

        UserDto userDto = new UserDto();
        userDto.setId(user.getId());
        userDto.setUsername(user.getUsername());
        userDto.setEmail(user.getEmail());
        userDto.setDisplayName(user.getDisplayName());
        userDto.setBio(user.getBio());
        userDto.setAvatar(user.getAvatar());
        userDto.setRole(user.getRole());
        userDto.setPostsCount(user.getPostsCount());
        userDto.setFollowersCount(user.getFollowersCount());
        userDto.setFollowingCount(user.getFollowingCount());
        return userDto;
    }


    public static UserUpdateDto toUpdateDto(User user) {
        UserUpdateDto dto = new UserUpdateDto();
        if (user != null) {
            dto.setName(user.getName() != null ? user.getName() : "");
            dto.setDisplayName(user.getDisplayName() != null ? user.getDisplayName() : "");
            dto.setAvatar(user.getAvatar() != null ? user.getAvatar() : "");
            dto.setBio(user.getBio() != null ? user.getBio() : "");
        } else {
            dto.setName("");
            dto.setDisplayName("");
            dto.setAvatar("");
            dto.setBio("");
        }
        return dto;
    }

}

