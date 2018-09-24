//zhoupenggang
#ifndef SCORE_H
#define SCORE_H

#include <QObject>

class Score : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int score READ score WRITE setScore NOTIFY scoreChanged)

public:
    explicit Score(QObject *parent = nullptr);

    Q_INVOKABLE void resetScore();
    int score() const;
    void setScore(int score);

signals:
    void scoreChanged();

public slots:

private:
    int m_score;
};

#endif // SCORE_H
