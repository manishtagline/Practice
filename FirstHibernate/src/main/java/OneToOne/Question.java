package OneToOne;

import javax.persistence.*;

@Entity
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String questionTitle;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "answerId")
    private Answer answer;

    public Question() {
    }

    public Question(int id, String questionTitle, Answer answer) {
        this.id = id;
        this.questionTitle = questionTitle;
        this.answer = answer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQuestionTitle() {
        return questionTitle;
    }

    public void setQuestionTitle(String questionTitle) {
        this.questionTitle = questionTitle;
    }

    public Answer getAnswer() {
        return answer;
    }

    public void setAnswer(Answer answer) {
        this.answer = answer;
    }
}
