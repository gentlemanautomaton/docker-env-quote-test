FROM debian:9

ENV DQUOTE One "two two" three four
ENV SQUOTE One 'two two' three four
ENV SBACKSLASH One two\ two three four
ENV DBACKSLASH One two\\ two three four
ENV BACKTICK One `two two` three four

CMD ["/bin/sh", "-c", "echo $DQUOTE; echo $SQUOTE; echo $SBACKSLASH; echo $DBACKSLASH; echo $BACKTICK"]

