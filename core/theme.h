#ifndef THEME_H
#define THEME_H

#include <QObject>
#include <QColor>

class Theme : public QObject
{
    Q_OBJECT
    Q_ENUMS(FontColor)
    Q_ENUMS(BackgroundColor)
public:
    explicit Theme(QObject *parent = 0);

    enum FontColor
    {
        DefaultColor,
        TextColor,
        TestColor
    };

    enum BackgroundColor
    {
        SecondaryColor
    };

    Q_INVOKABLE QColor fontColor(const FontColor &color) const;
    Q_INVOKABLE QColor backgroundColor(const BackgroundColor &color) const;

signals:

public slots:

};

#endif // THEME_H
