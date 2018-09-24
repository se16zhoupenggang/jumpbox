#include "score.h"

Score::Score(QObject *parent)
    : QObject(parent), m_score{0}
{}


void Score::resetScore()
{
    m_score = 0;
}

int Score::score() const
{
    return m_score;
}

void Score::setScore(int score)
{
    m_score = score;
    emit scoreChanged();
}
