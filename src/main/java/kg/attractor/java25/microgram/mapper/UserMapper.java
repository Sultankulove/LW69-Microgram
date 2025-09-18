package kg.attractor.java25.microgram.mapper;

import kg.attractor.java25.microgram.dto.UserDto;
import kg.attractor.java25.microgram.dto.UserRegisterDto;
import kg.attractor.java25.microgram.dto.UserRequestDto;
import kg.attractor.java25.microgram.dto.UserResponseDto;
import kg.attractor.java25.microgram.model.User;

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

    public static User userRegister(UserRegisterDto dto){
        if (dto == null) return null;
        User user = new User();
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword());
        return user;
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
}
