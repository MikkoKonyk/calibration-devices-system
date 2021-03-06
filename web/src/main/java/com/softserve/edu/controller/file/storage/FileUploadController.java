package com.softserve.edu.controller.file.storage;

import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.softserve.edu.service.VerificationPhotoService;

@Controller
@RequestMapping(value = "/uploadFile")
public class FileUploadController {

    @Autowired
    VerificationPhotoService verificationPhotoService;

    private static final String contentExtPattern = "^.*\\.(jpg|JPG|gif|GIF|doc|DOC|pdf|PDF)$";

    @RequestMapping(method = RequestMethod.GET)
    public String uploadFile() {
        return "/WEB-INF/views/upload.jsp";
    }

    @RequestMapping(method = RequestMethod.POST)
    public @ResponseBody String uploadFileHandler(
            @RequestParam(value = "testId") long testId,
            @RequestParam("file") MultipartFile file) {

        try {
            String fileType = file.getOriginalFilename().substring( 
                    file.getOriginalFilename().lastIndexOf('.'));
                if (Pattern.compile(contentExtPattern, Pattern.CASE_INSENSITIVE).matcher(fileType).matches()) {
                verificationPhotoService.putResourse(testId, file.getInputStream(), fileType);

                return "You successfully uploaded file";
            } else {
                return "Wrong file type";
            }
        } catch (Exception e) {
            return "You failed to upload => " + e.getMessage();
        }
    }
}