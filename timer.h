#ifndef TIMER_H
#define TIMER_H

#include <QObject>
#include <QTimer>

class Timer:public QTimer
{
    Q_OBJECT
    Q_PROPERTY(int second READ second WRITE setSecond NOTIFY secondChanged)
public:
    Timer(QObject *parent=nullptr);
    Q_INVOKABLE void startTimer();
    Q_INVOKABLE void stopTimer();

    int second() const;
    void setSecond(int second);

signals:
    void callChangeImage(int num);
    void secondChanged();
private:
    int m_second;
};

#endif // TIMER_H
