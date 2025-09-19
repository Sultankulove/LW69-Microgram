    package kg.attractor.java25.microgram.controller;
    import jakarta.validation.Valid;
    import kg.attractor.java25.microgram.dto.*;
    import kg.attractor.java25.microgram.mapper.UserMapper;
    import kg.attractor.java25.microgram.model.Follow;
    import kg.attractor.java25.microgram.model.Post;
    import kg.attractor.java25.microgram.model.User;
    import kg.attractor.java25.microgram.service.FollowService;
    import kg.attractor.java25.microgram.service.PostService;
    import kg.attractor.java25.microgram.service.UserService;
    import lombok.RequiredArgsConstructor;
    import lombok.extern.slf4j.Slf4j;
    import org.springframework.http.ResponseEntity;
    import org.springframework.security.core.Authentication;
    import org.springframework.stereotype.Controller;
    import org.springframework.ui.Model;
    import org.springframework.validation.BindingResult;
    import org.springframework.web.bind.annotation.*;

    import java.util.HashMap;
    import java.util.List;
    import java.util.Map;
    import java.util.Optional;
    import java.util.stream.Collectors;

    @Controller
    @RequestMapping("auth")
    @RequiredArgsConstructor
    @Slf4j
    public class UserController {
        private final UserService userService;
        private final PostService postService;
        private final FollowService followService;

        @GetMapping("/login")
        public String login(Model model, @RequestParam(defaultValue = "false") Boolean error) {
            model.addAttribute("error", error);
            return "auth/login";
        }

        @GetMapping("/register")
        public String register(Model model) {
            model.addAttribute("userRegisterDto", new UserRegisterDto());
            return "auth/register";
        }

        @PostMapping("/register")
        public String userRegister(@Valid UserRegisterDto userRegisterDto, BindingResult bindingResult, Model model) {
            log.info("Попытка регистрации пользователя: {}", userRegisterDto.getEmail());
            if (bindingResult.hasErrors()) {
                model.addAttribute("userRegisterDto", userRegisterDto);
                return "auth/register";
            }
            userService.register(userRegisterDto);
            return "redirect:/auth/login";
        }

        @GetMapping("/{id}")
        private ResponseEntity<UserResponseDto> getUserById(@PathVariable Long id) {
            log.info("Запрос пользователя по id={}", id);
            User user = userService.getById(id);
            UserResponseDto dto = UserMapper.toDto(user);
            return ResponseEntity.ok(dto);
        }

        @GetMapping("/search")
        private ResponseEntity<List<UserResponseDto>> searchUser(@RequestParam String keyword) {
            log.info("Поиск пользователей по ключевому слову: {}", keyword);
            List<User> user = userService.search(keyword);
            List<UserResponseDto> dto = user.stream()
                    .map(UserMapper::toDto)
                    .collect(Collectors.toList());

            return ResponseEntity.ok(dto);
        }

//@GetMapping("profile/{id}/followers")
//public String followers(@PathVariable Long id, Model model) {
//            User user = userService.getById(id);
//            List<Follow> followers = followService.getFollower(user);
//            model.addAttribute("followers", followers);
//            return "followers";
//}

        @GetMapping("profile/{id}/followers")
        public String followers(@PathVariable Long id, Model model) {
            User user = userService.getById(id);
            List<Follow> followers = followService.getFollower(user);


            UserFollowerDto ownerDto = UserMapper.toFollowerDto(user);


            List<UserFollowerDto> followerDtos = followers.stream()
                    .map(f -> UserMapper.toFollowerDto(f.getFollower()))
                    .toList();

            model.addAttribute("owner", ownerDto);
            model.addAttribute("followers", followerDtos);
            return "followers";
        }

        @GetMapping("profile/{id}/following")
        public String following(@PathVariable Long id, Model model) {
            User user = userService.getById(id);


            List<Follow> followings = followService.getFollowing(user);


            UserFollowerDto ownerDto = UserMapper.toFollowerDto(user);


            List<UserFollowerDto> followingDtos = followings.stream()
                    .map(f -> UserMapper.toFollowerDto(f.getFollowing()))
                    .toList();

            model.addAttribute("owner", ownerDto);
            model.addAttribute("following", followingDtos);
            return "following";
        }



        @PostMapping("/follow/{id}")
        public ResponseEntity<Map<String, Boolean>> follow(@PathVariable("id") Long followingId, Authentication auth) {
            User follower = userService.findByEmail(auth.getName());
            User following = userService.getById(followingId);

            boolean followingNow;
            if (followService.isFollowing(follower, following)) {

                followService.unfollow(follower, following);
                followingNow = false;
            } else {

                followService.follow(follower, following);
                followingNow = true;
            }

            Map<String, Boolean> result = new HashMap<>();
            result.put("following", followingNow);
            return ResponseEntity.ok(result);
        }

        @PostMapping("/unfollow/{id}")
        public ResponseEntity<String> unfollow(@PathVariable("id") Long followingId, Authentication auth) {
            User follower = userService.findByEmail(auth.getName());
            User following = userService.getById(followingId);

            followService.unfollow(follower, following);

            return ResponseEntity.ok("Отписка выполнена");
        }








        @GetMapping("/profile")
        public String viewProfile(
                Model model,
                Authentication auth) {
            User user = userService.findByEmail(auth.getName());

            UserProfileDto userProfileDto = userService.getUserProfileByUserId(user.getId());

            model.addAttribute("userProfileDto", userProfileDto);
            return "profile/profile";
        }

        @GetMapping("/profile/{id}")
        public String getProfile(@PathVariable Long id, Model model) {

            UserProfileDto userProfileDto = userService.getUserProfileByUserId(id);
            model.addAttribute("userProfileDto", userProfileDto);

            return "profile/usersProfile";
        }


        @GetMapping("/update")
        public String updateUser(Model model, Authentication authentication) {
           User user = userService.findByEmail(authentication.getName());
            UserUpdateDto dto = UserMapper.toUpdateDto(user);
            model.addAttribute("userUpdateDto", dto);
            return "profile/editUser";
        }

        @PostMapping("/update")
        public String updateProfile(@ModelAttribute("userUpdateDto") UserUpdateDto dto,
                                    Authentication auth) {
            userService.updateUser(dto, auth);
            return "redirect:/auth/profile";
        }



    }
