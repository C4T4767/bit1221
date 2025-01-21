package kr.bit.mapper;

import java.util.List;
import kr.bit.beans.Student;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface StudentMapper {

    @Insert("INSERT INTO name(name) VALUES(#{name})")
    @Options(useGeneratedKeys = true, keyProperty = "name_id")
    void saveName(Student student);

    @Insert("INSERT INTO info(name_id, place, school, dept) VALUES(#{name_id}, #{place}, #{school}, #{dept})")
    void saveInfo(Student student);

    @Select("SELECT n.id AS name_id, n.name, i.id AS info_id, i.place, i.school, i.dept FROM name n LEFT OUTER JOIN info i ON n.id = i.name_id")
    List<Student> findAll();

    @Select("SELECT n.id AS name_id, n.name, i.id AS info_id, i.place, i.school, i.dept FROM name n LEFT OUTER JOIN info i ON n.id = i.name_id WHERE n.name LIKE '%${name}%'")
    List<Student> findAllByName(@Param("name") String name);
}
