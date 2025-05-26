package OneToOne;

import javax.persistence.*;

@Entity
public class Answer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String answerTitle;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "questionId")
    private Question question;

    public Answer(int id, String answerTitle, Question question) {
        this.id = id;
        this.answerTitle = answerTitle;
        this.question = question;
    }

    public Answer() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAnswerTitle() {
        return answerTitle;
    }

    public void setAnswerTitle(String answerTitle) {
        this.answerTitle = answerTitle;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }
}
