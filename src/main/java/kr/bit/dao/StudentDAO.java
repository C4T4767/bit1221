package kr.bit.dao;

import java.util.List;
import kr.bit.beans.Student;
import kr.bit.mapper.StudentMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@Transactional
public class StudentDAO{

    @Autowired
    private StudentMapper studentMapper;

    public Student getStudentByName(String name) {
        return studentMapper.getStudentByName(name);
    }

    public Student updateStudent(String name, Student student) {
        Student existingStudent = studentMapper.getStudentByName(name);
        if (existingStudent == null) {
            return null;
        }

        student.setName_id(existingStudent.getName_id());
        student.setInfo_id(existingStudent.getInfo_id());


        studentMapper.studentUpdate(student);


        return studentMapper.getStudentByName(student.getName());
    }

    public void nameDelete(int id) {
        studentMapper.nameDelete(id);
    }

    public void infoDelete(int id) {
        studentMapper.infoDelete(id);
    }

public void save(Student student) {
    studentMapper.saveName(student);
    studentMapper.saveInfo(student);
}

public List<Student> findAll() {
    return studentMapper.findAll();
}

public List<Student> findByName(String name) {
    return studentMapper.findAllByName(name);
}
}
