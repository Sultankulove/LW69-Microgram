package kg.attractor.java25.microgram.service.imp;

import kg.attractor.java25.microgram.dto.image.AvatarDto;
import kg.attractor.java25.microgram.dto.image.ImageDto;
import kg.attractor.java25.microgram.exceptions.NotFoundException;
import kg.attractor.java25.microgram.model.Post;
import kg.attractor.java25.microgram.model.User;
import kg.attractor.java25.microgram.repository.PostRepository;
import kg.attractor.java25.microgram.repository.UserRepository;
import kg.attractor.java25.microgram.service.ImageService;
import kg.attractor.java25.microgram.util.FileUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ImageServiceImpl implements ImageService {
    private static final String AVATAR_SUB_DIR = "avatar";
    private static final String IMAGE = "image";

    private final UserRepository userRepository;
    private final PostRepository postRepository;

    public void uploadImage(ImageDto dto) {
        Post post = postRepository.findById(dto.getPostId())
                .orElseThrow(() -> new NotFoundException("User id=" + dto.getPostId()));
        String image = FileUtil.saveUploadedFile(dto.getImage(), IMAGE);
        int updated = postRepository.savePostImage(image, post.getId());
        if (updated == 0) throw new NotFoundException("post id=" + post.getId() + ", post image not uploaded");

    }

    @Override
    public ResponseEntity<?> downloadImageByPostId(Long postId) {
        String image = postRepository.getImageById(postId)
                .orElseThrow(() -> new NotFoundException("post id=" + postId));
        return FileUtil.downloadImage(image, IMAGE);
    }


    @Transactional
    @Override
    public void uploadAvatar(AvatarDto dto) {

        User user = userRepository.findById(dto.getUserId())
                .orElseThrow(() -> new NotFoundException("User id=" + dto.getUserId()));
        String avatar = FileUtil.saveUploadedFile(dto.getAvatar(), AVATAR_SUB_DIR);
        int updated = userRepository.saveAvatar(avatar, user.getId());
        if (updated == 0) throw new NotFoundException("User id=" + user.getId() + ", avatar not uploaded");

    }

    @Override
    public ResponseEntity<?> getAvatarById(Long id) {


        String avatar = userRepository.getAvatarById(id)
                .orElseThrow(() -> new NotFoundException("Avatar for user id=" + id));
        if (avatar!=null) {
            return FileUtil.downloadImage(avatar, AVATAR_SUB_DIR);
        }
        return FileUtil.downloadImage("default.jpg", AVATAR_SUB_DIR);
    }


}
