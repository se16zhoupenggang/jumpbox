#include "timer.h"

Timer::Timer(QObject *parent)
    :QTimer(parent)
{
    this->setSingleShot(false);
    connect(this,&Timer::timeout,[&]{
        emit callChangeImage(rand()%3);
    });
    connect(this,&Timer::secondChanged,[&]{
        if(this->isActive())stopTimer();
        this->setInterval(m_second*1000);
    });
}

void Timer::startTimer()
{
    this->start();
}

void Timer::stopTimer()
{
    this->stop();
}

int Timer::second() const
{
    return m_second;
}

void Timer::setSecond(int second)
{
    m_second = second;
    emit secondChanged();
}
